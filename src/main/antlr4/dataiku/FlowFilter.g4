grammar FlowFilter;

parse
 : expression? EOF
 ;

expression:
    LPAREN expression RPAREN                                                #parenExpression
    | NOT expression                                                        #notExpression
    | left=expression op=operator? right=expression                         #binaryExpression
    | key=(TAG|USER|DOWNSTREAM_FROM) value=selectorTextValue                    #selectorTextExpression
    | key=(CREATED_FROM|CREATED_TO|CREATED_ON) value=selectorDateValue        #selectorDateExpression
    ;
text
   : STRING_LITERAL
   ;
selectorTextValue:
    VALUE | text
    ;
selectorDateValue:
    date|dateTime
    ;
date:
    DATE
    ;
dateTime:
    DATETIME
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
DATE : [0-9][0-9]'/'[0-9][0-9]'/'[0-9][0-9][0-9][0-9];
DATETIME : DATE ' ' [0-9][0-9]':'[0-9][0-9]':'[0-9][0-9];
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
