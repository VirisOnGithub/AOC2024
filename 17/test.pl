use v5.16;
use Syntax::Keyword::Match;
my $n = 1;
match($n : ==) {
   case(1) { print "It's one" }
   case(2) { print "It's two" }
   case(3) { print "It's three" }
   case(4), case(5)
           { print "It's four or five" }
   case if($n < 10)
           { print "It's less than ten" }
   default { print "It's something else" }
}