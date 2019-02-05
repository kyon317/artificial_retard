
#include "Scanner.h"
#include "Stack.h"  // GENERIC STACK

#include <iostream>
using namespace std;

int operation(TokenType tt,int a,int b)
{
	int x;
	switch(tt)
	{
       	case pltok:x = a+b;break;
        case mitok:x = a-b;break;
       	case asttok:x = a*b;break;
        case slashtok:x = a/b;break;
    }
	return x;
}

int main () {
    Scanner S(cin);
    Token t;

    Stack<Token> numstack, opstack;  // 2x Stacks of type Token
    t = S.getnext();
    while (t.tt != eof||!opstack.isEmpty()) 
	{
        if (t.tt == integer ) {
            numstack.push(t);
            t = S.getnext();
        } 
        else if (t.tt == lptok) 
        {
           opstack.push(t);
           t = S.getnext();
        }
        else if (t.tt == rptok)
        {
            
        	Token flag = opstack.peek();
        	if (flag.tt==lptok)
        	{
        		opstack.pop();
        		t = S.getnext();
        	}
        	else
        	{
        		Token a = numstack.pop();
        		Token b = numstack.pop();
        		Token op = opstack.pop();
                Token res;
        		res.val = operation(op.tt,b.val,a.val);
        		
        		numstack.push(res);

        	}
    	}

    	else if (t.tt == pltok||t.tt == mitok||t.tt == eof)
    	{
    		if (!opstack.isEmpty())
    		{
            
    			Token op = opstack.peek();
    			if (op.tt == pltok||op.tt == mitok||op.tt == asttok || op.tt == slashtok)
    			{
    			Token a = numstack.pop();
        		Token b = numstack.pop();
                Token res;
        		op = opstack.pop();
        		res.val = operation(op.tt,b.val,a.val);
        		numstack.push(res);
    			}
    		}
    		else
    		{
    			opstack.push(t);
          		t = S.getnext();
    		}
    	}
    	else if (t.tt == asttok || t.tt == slashtok)
    	{
    		if (!opstack.isEmpty())
    		{
                
    			Token op = opstack.peek();
    			if (op.tt == asttok || op.tt == slashtok)
    			{
    			Token a = numstack.pop();
        		Token b = numstack.pop();
                Token res;
        		op = opstack.pop();
        		res.val = operation(op.tt,b.val,a.val);
        		numstack.push(res);
    			}
    		}
    		else
    		{
    			opstack.push(t);
          		t = S.getnext();
    		}
    	}
    }


    	Token Result = numstack.pop();
    	cout<<"The result is "<<Result.val<<endl;
    return 0;
}

