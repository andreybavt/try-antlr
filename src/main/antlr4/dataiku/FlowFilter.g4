grammar FlowFilter;

parse
 : expression? EOF
 ;

expression:
    LPAREN expression RPAREN                                 #parenExpression
    | NOT expression                                         #notExpression
    | left=expression op=operator? right=expression          #binaryExpression
    | key=selectorKey value=selectorValue                    #selectorExpression
    ;
text
   : STRING_LITERAL
   ;
selectorKey:
    TAG | USER
    ;
selectorValue:
    VALUE | text
    ;
operator:
    AND
    | OR
    ;

LPAREN : '(';
RPAREN : ')';
AND               : 'AND' ;
OR                : 'OR' ;
NOT                : 'NOT' ;

VALUE
   : ~ ('"' | ':' | ' ' | '\t' | '\r'| '\n' | '(' | ')')+
   ;

TAG               : 'tag:' ;
USER              : 'user:' ;
CREATED_ON        : 'createdOn:' ;
CREATED_FROM      : 'createdFrom:' ;
CREATED_TO        : 'createdTo:' ;
DOWNSTREAM_FROM   : 'downstreamFrom:' ;

WS
   : [ \t\r\n] -> skip
   ;
STRING_LITERAL
   : '"' ('\\"' | ~ ('"'))* '"'
   ;
DIGIT             : [0-9];

