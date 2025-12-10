#ifndef INPUT_BUFFER_H
#define INPUT_BUFFER_H

#include <stddef.h>

#define INPUT_BUFFER_SIZE 256

void input_buffer_init(void);
void input_buffer_put(char c);   // called by keyboard handler (later)
int  getc(void);                 // returns -1 if buffer empty
int  readline(char *buf, size_t max_len);

#endif
