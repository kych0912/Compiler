%{
#define LINESPACE 255
#define NUMBER 256
#define OPERATOR 257
#include<stdio.h>
struct Stack{
        int top;
        unsigned capacity;
        char** arr;

};
%}
digit [0-9]+
%%
{digit} {return NUMBER;}
"-"|"+" {return OPERATOR;}
. {}
\n {return LINESPACE;}

%%


struct Stack* createStack(unsigned capacity){
        struct Stack* stack = (struct Stack*)malloc(sizeof(struct Stack));
        stack->capacity = capacity;
        stack->top = -1;
        stack->arr = (char*)malloc(stack->capacity*sizeof(char));
        return stack;
}

int isFull(struct Stack* stack){
        return stack->top==stack->capacity-1;
}

int isEmpty(struct Stack* stack){
        return stack->top==-1;
}

void push(struct Stack* stack, char item){
        if(isFull(stack))
                return;
        stack->arr[++stack->top]=item;

}

char pop(struct Stack* stack){
        if(isEmpty(stack))
                return '\0';
        return stack->arr[stack->top--];
}

char peek(struct Stack* stack){
        if(isEmpty(stack))
                return '\0';
        return stack->arr[stack->top];
}


int main(int argc, char **argv){

struct Stack* stack = createStack(100);

int token;
while((token=yylex())){
        switch(token){

        case NUMBER: printf("%s ",yytext); break;
        case OPERATOR:
                if(!isEmpty(stack)){
                        printf("%c ",pop(stack));
                }
                push(stack,yytext[0]);
                break;
        case LINESPACE:
                while(!isEmpty(stack)){
                        printf("%c ",pop(stack));
                }
                printf("\n");
                break;
        default: printf("Error\n");break;
        }
        
}
return 0;
}

