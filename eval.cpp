
#include "Scanner.h"
#include "Stack.h"  // GENERIC STACK

#include <iostream>
using namespace std;



int main () {
    Scanner S(cin);
    Token t;

    Stack<Token> numstack, opstack;  // 2x Stacks of type Token
    

    t = S.getnext();

    while (t.tt != eof) {
        if (t.tt == integer ) {
            numstack.push(t.tt);
            t = S.getnext();
        } else if (t.tt == lptok) 
        {
           opstack.push(t.tt);
           t = S.getnext();
        }else if (t.tt == rptok)
        {
        	if (opstack.peek()==lptok)
        	{
        		opstack.pop();
        		t = S.getnext();
        	}
        	else
        	{
        		int a = numstack.pop();
        		int b = numstack.pop();
        		switch(opstack.peek())
        		case '+':b+=a;break;
        		case '-':b-=a;break;
        		case '*':b*=a;break;
        		case '/':b*=a;break;
        		numstack.push(b);
        	}
        }
        else if (t.tt == pltok||t.tt == mitok||t.tt == eof)
        {
        	if (!(opstack.isEmpty())&&(opstack.peek()==pltok||opstack.peek()==mintok||opstack.peek()==astok||opstack.peek()==slashtok))
        	{
        		int a = numstack.pop();
        		int b = numstack.pop();
        		switch(opstack.peek())
        		case '+':b+=a;break;
        		case '-':b-=a;break;
        		case '*':b*=a;break;
        		case '/':b*=a;break;
        		numstack.push(b);
        	}
        	else{
        		opstack.push(t.tt);
        		t = S.getnext();
        	}
        }
        else if (t.tt==astok||t.tt == slashtok)
        {
        	if (!(opstack.isEmpty())&&(opstack.peek()==astok||opstack.peek()==slashtok))
        	{
        		int a = numstack.pop();
        		int b = numstack.pop();
        		switch(opstack.peek())
        		case '+':b+=a;break;
        		case '-':b-=a;break;
        		case '*':b*=a;break;
        		case '/':b*=a;break;
        		numstack.push(b);
        	}
        	else
        	{
        		opstack.push(t.tt);
        		t = S.getnext();
        	}	
        }

        
    }



    return 0;
}

