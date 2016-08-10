class UserFilesController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :create, :todata, :tocsv]
  
  def download
      userfile = UserFile.find(param_file)

      send_file userfile.file.path
  end
  
  def index
   @files = UserFile.all
   @db = ErrorLog.all
  end
  
  
  def new
    @file = UserFile.new
  end
  
  def create
    @user = User.find(session[:user_id])
    @file = @user.user_files.build(file_params)
    @file.save
    redirect_to @user
  end
  
  def show
  end
  def todata
    @user = User.find(session[:user_id])
    require 'csv'
      db = @user.error_logs.build
      db.name = Time.now.asctime
      db.save
      CSV.foreach(file_path[:file_path]) do |row|
    #Read in csv line by line
      #read each line as a array of sperate values
      level = row.shift.to_i
      symbol = row.shift
      #find pair by array values 0 and 2
      db.pairs.create( level: level, symbol: symbol, vamount: (row.size/4)) unless db.pairs.find_by( level: level, symbol: symbol)
      #load time
      pr = db.pairs.find_by( level: level, symbol: symbol)
      ev = pr.events.create(time: row.shift.to_i)
      #turn each value into propoer object
      while row.size >= 4 do

        ev.variables.create(no: row.shift.to_i, name: row.shift, vtype: row.shift, value: row.shift)
      end
    end
    db.save
    redirect_to @user
  end
  
  def tocsv
    require 'ArduinoStringToNum'
    #create csv version of file
    temp_path = Pathname.new(file_path[:file_path] + ".csv")
    puts "!!!!!!!!!!!!!!!"
    puts file_path[:file_path]
    puts "!!!!!!!!!!!!!!"
    File.open(temp_path.to_s,'w+'){ |i|
      File.open(file_path[:file_path], 'r'){ |j|
       # just writes name i.write(j)
        
        j.each_line{|line|
           #remove end of line
    line.gsub!(/\r\n?/, )
    line.gsub!(/\n?/, )
    out_string = String.new
     next if line.blank?
    #map each hex pair to a fixnum
    out = line.scan(/../).map{|x| x.hex} 
    
       
    #remove the first hex pair
    y = out.shift
    #get the level
    l = ((y|7)>>5)
    #get the symbol, and add 0100000, to give ascii range 64-95
    s = ((y&0b00011111)|0b01000000).chr
    if ('@'.ord..'_'.ord) === s.ord && (0..7) === l 
        out_string << "#{l}," + s
    else
        out_string << "Invalid level,Invalid symbol"
    end
    
     #grab the time
     time = ArduinoStringToNum.new(out.shift(4).map!{|x| x.to_s(2)}.join).to_ulong
     out_string << ',' + time.to_s
    
    #Now we loop threw array values to find varible values
    index = 0
    varible_no = 0
   
    while index <= (out.size - 1) do
        x = out[index].to_i
        index += 1
        if !((0..127) === x) # test if is valid asci 
            next
        end
        #jump case for values of type of x
        case x.chr
        when 'c' ,'C'
            binary  =  ArduinoStringToNum.new(out.slice(index, 1).map!{|value| value.to_s(2).rjust(8,'0')}.join).to_int
            next if !((0..127) === binary) # test if is valid asci 
            out_string << ",#{varible_no},Unnamed,chr," + binary.chr
            index += 1
            varible_no += 1
        when 'b' ,'B'
            binary  =  ArduinoStringToNum.new(out.slice(index, 1).map!{|value| value.to_s(2).rjust(8,'0')}.join).to_byte
            out_string << ",#{varible_no},Unnamed,byte," + binary.to_s
            index += 1
            varible_no += 1
        when 'f' ,'F'
            binary  =  ArduinoStringToNum.new(out.slice(index, 4).map!{|value| value.to_s(2).rjust(8,'0')}.join).to_ieee754
            #covert to IEEE Standard 754
            out_string << ",#{varible_no},Unnamed,float," + binary.to_s
            index += 4
            varible_no += 1
        when 'i' ,'I'
            binary  =  ArduinoStringToNum.new(out.slice(index, 2).map!{|value| value.to_s(2).rjust(8,'0')}.to_ArdB.join).to_int
            out_string << ",#{varible_no},Unnamed,int," + binary.to_s
            varible_no += 1
        when 'l' ,'L'
            binary  =  ArduinoStringToNum.new(out.slice(index, 4).map!{|value| value.to_s(2).rjust(8,'0')}.join).to_long
            out_string << ",#{varible_no},Unnamed,long," + binary.to_s
            index += 4
            varible_no += 1
        else
            next    
        end
      
      
      
    end
    puts out_string 
  
          i.write(out_string + "\n")
        }
      }
      
    }
    @user = User.find(session[:user_id])
    temp_uploader =  @user.user_files.build
    temp_uploader.file =  temp_path.open
    temp_uploader.save!
    temp_path.delete
    redirect_to @user
  end
  
    def destroy
        @user = User.find(session[:user_id])
        @file = UserFile.find(params[:id])
        @file.remove_file!
        @file.destroy
        flash[:success] = "User deleted"
        
    redirect_to @user
    end

  private 
    def param_file
      params.require(:file_identifier)
    end
    
    def file_id
      params.require(:user_file).permit(:file, :user_id)
    end
    def file_params
      params.require(:user_file).permit(:file, :user_id)
    end
    
    def file_path
      params.permit(:file_path)
    end
    
        # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
end
