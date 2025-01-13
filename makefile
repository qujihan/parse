# 编译器
CC = gcc
# 编译选项
CFLAGS = -g
# 目标文件
OBJS = ccalc.o cmath.o lex.o parse.o
# 头文件
HEADERS = parse.h ccalc.h
# 中间文件
LEX_C = lex.c
PARSE_C = parse.c
LEX_D = lex.d
PARSE_D = parse.d

# 默认目标
.PHONY: all
all: ccalc

# 最终可执行文件
ccalc: $(OBJS)
	$(CC) $(CFLAGS) -o ccalc $(OBJS)

# 编译目标文件
%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $<

# 生成 lex.c 规则
$(LEX_C): lex.l
	flex -o$(LEX_C) -i $<

# 生成 parse.c 规则
$(PARSE_C): parse.y
	bison -o $(PARSE_C) $<

# 编译 ccalc.o
ccalc.o: ccalc.c $(HEADERS) $(LEX_C) $(PARSE_C)

# 编译 cmath.o
cmath.o: cmath.c $(HEADERS)

# 编译 lex.o
lex.o: lex.c $(HEADERS) $(LEX_C)

# 编译 parse.o
parse.o: parse.c $(HEADERS) $(PARSE_C)

# 清理生成的文件
.PHONY: clean
clean:
	rm -f $(OBJS) $(LEX_C) $(PARSE_C) $(LEX_D) $(PARSE_D) ccalc