options
{
STATIC = false ;
}
PARSER_BEGIN(Adder)
public class Adder
{
public static void main( String[] args ) throws ParseException, Exception
{
try
		{		
     		Adder parser = new Adder( System.in ) ;
            parser.Start() ;
			System.out.println("\tSyntax is okay.");			
		}
		catch(ParseException e)
		{
			System.out.println(e.getMessage());
			System.out.println("\tSyntax is not okay.");
		}


}
}
PARSER_END(Adder)


TOKEN : 
{ 
	  <ASSIGN : "=">  
	| <PLUS : "+" >  
	| <MINUS:"-"> 
	| <MULTIPLY:"*"> 
	| <DIVIDE:"/"> 
	| <INCR: "++" > 
	| <DECR: "--" > 
	
}

TOKEN:
{
	  <EQ: "==" > 
	| <SE: "<=" > 
	| <SM: "<" > 
	| <GE: ">=" > 
	| <GR: ">" > 
	| <DIF: "!=" > 
	
}	

TOKEN:
{
      <LPAREN: "(" > 
	| <RPAREN: ")" > 
	| <LBRACE: "{" > 
	| <RBRACE: "}" > 
	| <SEMIC: "€" > 
	| <COMMA: "," > 
	| <DOT: "." > 
	| <DOUBLECOMMA: "\"">
}




TOKEN :
{
 
	  <IF: "eher" > 
	| <ELSE: "noch" > 
	| <ELSEIF: "noch eher" >
	| <WRITE: "schreibe" >
}

TOKEN:
{
	  <INT:"deutschin"> 
	| <DOUBLE: "deutschdoub"> 
	| <CHR: "deutschchr"> 
	| <STR: "deutschstr"> 

}

TOKEN : 
{ 
      < NUMBER : (["0"-"9"])+ > 
    | < IDENTIFIER : (["a"-"z","A"-"Z"])+ > 
	| < START : "Begin Bl€ah.." >
	| < END : "..End Bl€ah" >
	| < CARAC : "'"["a"-"z","A"-"Z","0"-"9"]"'">
	| < STRING : <DOUBLECOMMA>["a"-"z","A"-"Z","0"-"9"," "](["a"-"z","A"-"Z","0"-"9"," ",":",";","."])*<DOUBLECOMMA>>
	
}

SKIP : { " " }
SKIP : { "\n" | "\r" | "\r\n" }

void Start() :
{}
{   
     < START >Main()< END > <EOF>
}

void Main() : 
{}
{
   ( <INT> | < DOUBLE > | < CHR > | < STR > )*< IDENTIFIER >(< ASSIGN >Expression())*(<COMMA><IDENTIFIER>)*< SEMIC >(VS())*
}


void VS() :
{}
{
    Main() | Other() 
}

void Other() :
{}
{
   LOOKAHEAD(3)ifStatement() | Write()  
}

void Write() :
{}
{
    <WRITE>(<IDENTIFIER> | <NUMBER>)<SEMIC>
}


void Expression() :
{}
{
   (<IDENTIFIER> | < NUMBER >)(( <PLUS> | <MINUS> | <MULTIPLY> | <DIVIDE> )(<IDENTIFIER> | < NUMBER >))*
}

void ifStatement():
{}
{
    <IF><LPAREN> A() <RPAREN> <LBRACE> Assign() <RBRACE> (<SEMIC> | (LOOKAHEAD(2)ifNot())*) (Write() | Main() )*
}

void A():
{}
{
  (<IDENTIFIER> | <NUMBER>) Comparing() (<IDENTIFIER> | <NUMBER>)
}


void Comparing() :
{}
{
   <EQ> | <SE> | <SM> | <GE> | <GR> | <DIF>
}


void Assign():
{}
{
  (<IDENTIFIER> | <NUMBER>) <ASSIGN> (<IDENTIFIER> | <NUMBER>)
}


void ifNot() :
{}
{
  LOOKAHEAD(2)<ELSE>Assign()<SEMIC> | LOOKAHEAD(2)elseifStatement() (<SEMIC> | (LOOKAHEAD(2)<ELSE>Assign()<SEMIC>)*)
}


void elseifStatement() :
{}
{
   <ELSEIF><LPAREN> A() <RPAREN> <LBRACE> Assign() <RBRACE>
}


