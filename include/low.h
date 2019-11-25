// -----------------------------------------------------------------------------
//  low.h - native module API which does not belong to stdlib or DukTape
// -----------------------------------------------------------------------------

#ifndef __LOW_H__
#define __LOW_H__

#include "duktape.h"

#include <stdlib.h>
#include <stddef.h>
#include <stdbool.h>

typedef duk_context low_context;

typedef enum
{
    LOW_THREAD_CODE,
    LOW_THREAD_WORKER,
    LOW_THREAD_IMMEDIATE
} low_thread;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

__attribute__ ((visibility ("default"))) bool module_load(low_context *ctx, const char *module_path);
__attribute__ ((visibility ("default"))) bool module_unload();

void low_load_module(low_context *ctx, const char *path, bool parent_on_stack);

void low_call_thread(low_context *ctx, low_thread thread, int priority, void (*func)(low_context *ctx, void *userdata), void *userdata);
low_thread low_get_current_thread(low_context *ctx);

int low_set_timeout(low_context *ctx, int index, int delay, void (*call)(low_context *ctx, void *userdata), void *userdata);
void low_clear_timeout(low_context *ctx, int index);

void low_call_next_tick(low_context *ctx, int num_args);

int low_add_stash(low_context *ctx, int index);
void low_remove_stash(low_context *ctx, int index);
void low_push_stash(low_context *ctx, int index, bool remove);

void *low_push_buffer(low_context *ctx, int len);
void low_push_error(duk_context *ctx, int error, const char *syscall);

void *low_alloc_throw(low_context *ctx, size_t size);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#ifdef __cplusplus
inline void *operator new(size_t size, low_context *ctx)            { return low_alloc_throw(ctx, size); }
inline void *operator new[](size_t size, low_context *ctx)          { return low_alloc_throw(ctx, size); }

inline void operator delete(void *ptr, low_context *ctx)            { free(ptr); }
inline void operator delete[](void *ptr, low_context *ctx)          { free(ptr); }
#endif /* __cplusplus */

#endif /* __LOW_H__ */
