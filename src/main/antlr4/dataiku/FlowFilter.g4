grammar FlowFilter;

parse
 : expression? EOF
 ;

expression
 : expression  operator?  expression
 |  selector=SELECTOR COLON value=string
 ;

// OK
string:
    (text* | escapedtext* );

text:
    CHAR+ | DBL_QUOTE;


//todo "tag"
escapedtext
 : DBL_QUOTE value=anychar* DBL_QUOTE
 ;

anychar:
   CHAR | escape_chars | ANY_CHAR_IN_ESCAPE | COLON;

escape_chars:
    ESC_DBL_QUOTE;

operator
 : AND | OR
 ;

SELECTOR            : TAG | USER;
TAG               : 'tag' ;
DBL_QUOTE : '"';
COLON:':';
AND : 'AND';
OR : 'OR';
LPAREN            : '(' ;
RPAREN            : ')' ;

USER              : 'user' ;
CREATED_ON        : 'createdOn' ;
CREATED_FROM      : 'createdFrom' ;
CREATED_TO        : 'createdTo' ;
DOWNSTREAM_FROM   : 'downstreamFrom' ;
DIGIT             : [0-9];
ESC_DBL_QUOTE        : '\\"';
CHAR                : ~[ :];

ANY_CHAR_IN_ESCAPE    : ~["] ;
WS : [ \t\r\n]+ -> skip ;

