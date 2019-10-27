// -----------------------------------------------------------------------------
//  low_native.h - native module API which does not belong to stdlib or DukTape
// -----------------------------------------------------------------------------

#ifndef __LOW_NATIVE_H__
#define __LOW_NATIVE_H__

#include "duktape.h"

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

typedef duk_context low_context;

typedef enum
{
    LOW_THREAD_CODE,
    LOW_THREAD_WORKER_FAST,
    LOW_THREAD_WORKER_SLOW
} low_thread_type;

__attribute__ ((visibility ("default"))) int module_main(low_context *ctx, const char *module_path);

// Typically, in a native module parent_on_stack will be false
void low_load_module(low_context *ctx, const char *path, bool parent_on_stack);

void low_call_direct(low_context *ctx, low_thread_type thread, void (*func)(void *userdata), void *userdata);
low_thread_type low_current_thread_type(low_context *ctx);

int low_set_timeout(low_context *ctx, int index, int delay, void (*call)(void *data), void *data);
void low_clear_timeout(low_context *ctx, int index);

int low_add_stash(low_context *ctx, int index);
void low_remove_stash(low_context *ctx, int index);
void low_push_stash(low_context *ctx, int index, bool remove);

void *low_push_buffer(low_context *ctx, int len);
void low_call_next_tick(low_context *ctx, int num_args);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __LOW_NATIVE_H__ */
