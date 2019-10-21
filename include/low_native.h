
#ifndef __LOW_NATIVE_H__
#define __LOW_NATIVE_H__

#include "duktape.h"

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

typedef duk_context low_context;

enum low_thread_type
{
    LOW_THREAD_CODE,
    LOW_THREAD_WORKER_FAST,
    LOW_THREAD_WORKER_SLOW
};

int module_main(low_context *ctx);

int low_add_stash(low_context *ctx, int index);
void low_remove_stash(low_context *ctx, int index);
void low_push_stash(low_context *ctx, int index, bool remove);

void *low_push_buffer(low_context *ctx, int len);
void low_call_next_tick(low_context *ctx, int num_args);

void low_call_direct(low_context *ctx, low_thread_type thread, void (*func)(void *userdata), void *userdata);
low_thread_type low_current_thread_type(low_context *ctx);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __LOW_NATIVE_H__ */
