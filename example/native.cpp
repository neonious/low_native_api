// -----------------------------------------------------------------------------
//  native.c
// -----------------------------------------------------------------------------

#include "low_native.h"
#include "duktape.h"


// -----------------------------------------------------------------------------
//  native_method_simple_add - add method
// -----------------------------------------------------------------------------

int native_method_simple_add(duk_context *ctx)
{
    double a = duk_get_number_default(ctx, 0, 0);
    double b = duk_get_number_default(ctx, 1, 0);

    duk_push_number(ctx, a + b);
    return 1;
}


// -----------------------------------------------------------------------------
//  module_main - on stack: [module exports]
// -----------------------------------------------------------------------------

bool module_load(duk_context *ctx, const char *module_path)
{
    duk_function_list_entry methods[] = {{"simple_add", native_method_simple_add, 2},
                                         {NULL, NULL, 0}};
    duk_put_function_list(ctx, 1, methods);

    return true;
}
