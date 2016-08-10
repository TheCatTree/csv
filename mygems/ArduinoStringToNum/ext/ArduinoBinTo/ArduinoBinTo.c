#include "ruby.h"

union u32{
    uint8_t array[4];
    uint32_t bin;
    long l;
    unsigned long ul;
    float f;
};

union u16{
    uint8_t array[2];
    uint16_t bin;
    int i;
};


long String_to_bin(VALUE string){ //ruby string to a long with the appropriate binary value
    int i = RSTRING_LEN(string);
    int j = 0;
    long l =0;
    char *pintr = RSTRING_PTR(string);
    for(j = 0; j< i; j++){
        
        l = l << 1; // Move bit values 1 to the left
        if(*pintr == '1'){
            l = l + 1;
        }
        else if(*pintr == '0'){
        } 
        pintr = pintr + 1;
    }
    return l;
}
VALUE ArduinoBinTo = Qnil;

void Init_ArduinoBinTo();

VALUE method_to_ieee754(VALUE self);
VALUE method_to_long(VALUE self);
VALUE method_to_ulong(VALUE self);
VALUE method_to_byte(VALUE self);
VALUE method_to_char(VALUE self);
VALUE method_to_int(VALUE self);

void Init_ArduinoBinTo() {
    ArduinoBinTo = rb_define_module("ArduinoBinTo");
	rb_define_method(ArduinoBinTo, "to_ieee754", method_to_ieee754, 0);
	rb_define_method(ArduinoBinTo, "to_long", method_to_long, 0);
	rb_define_method(ArduinoBinTo, "to_ulong", method_to_ulong, 0);
	rb_define_method(ArduinoBinTo, "to_byte", method_to_byte, 0);
	rb_define_method(ArduinoBinTo, "to_char", method_to_char, 0);
	rb_define_method(ArduinoBinTo, "to_int", method_to_int, 0);
}

VALUE method_to_ieee754(VALUE self){
    VALUE string = StringValue(self);
    union u32 out;
    out.f = 0.0;
    out.bin = String_to_bin(string);
    uint8_t x = 0;
    x = out.array[0];
    out.array[0] = out.array[3];
    out.array[3] = x;
    x = out.array[1];
    out.array[1] = out.array[2];
    out.array[2] = x;
    return rb_float_new(out.f);
}

VALUE method_to_long(VALUE self){
    VALUE string = StringValue(self);
    union u32 out;
    out.l = 0;
    out.bin = String_to_bin(string);
    uint8_t x = 0;
    x = out.array[0];
    out.array[0] = out.array[3];
    out.array[3] = x;
    x = out.array[1];
    out.array[1] = out.array[2];
    out.array[2] = x;
    return LONG2FIX(out.l);
}

VALUE method_to_ulong(VALUE self){
    VALUE string = StringValue(self);
    union u32 out;
    out.l = 0;
    out.bin = String_to_bin(string);
    uint8_t x = 0;
    x = out.array[0];
    out.array[0] = out.array[3];
    out.array[3] = x;
    x = out.array[1];
    out.array[1] = out.array[2];
    out.array[2] = x;
    return ULONG2NUM(out.ul);
}

VALUE method_to_char(VALUE self){
    VALUE string = StringValue(self);
    char out;
    out = 0;
    out = (char)String_to_bin(string);
    char x[2];
    x[1] = '\0';
    x[0] = out;
    return rb_str_new2(x);
}

VALUE method_to_byte(VALUE self){
    VALUE string = StringValue(self);
    uint8_t out;
    out = 0;
    out = (uint8_t)String_to_bin(string);

    return UINT2NUM(out);
}

VALUE method_to_int(VALUE self){
    VALUE string = StringValue(self);
    union u16 out;
    out.i = 0;
    out.bin = (int)String_to_bin(string);
    uint8_t x = 0;
    x = out.array[0];
    out.array[0] = out.array[1];
    out.array[1] = x;
    return INT2FIX(out.i);
}