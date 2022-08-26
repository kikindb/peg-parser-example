json = _ literal:literal _ { return literal; }
literal = boolean / integer/ string / object / array / null

boolean = "true" { return true;} / "false" { return false; }
null  = "null"  { return null; }

integer "integer" = digits:[0-9]+ { return parseInt(digits.join(""), 10); }

string "string" = quotation_mark chars:char* quotation_mark { return chars.join(""); }

char = unescaped
     / escape
      sequence:(
        '"'
      / "\\"
      / "/"
      / "b" { return "\b"; }
      / "f" { return "\f"; }
      / "n" { return "\n"; }
      / "r" { return "\r"; }
      / "t" { return "\t"; }
      / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
          return String.fromCharCode(parseInt(digits, 16));
        }
    )
    { return sequence; }

array = "[" _ "]" { return []; }
      / "[" first:literal _ rest:("," _ literal _)* "]" { return [first].concat(rest.map(e => e[2]));}

_ "whitespace"
  = [ \t\n\r]*

object = "{" _ "}" { return {}; }
       / "{" _ first:item _ rest:("," _ item _)* "}" {
       	var result = {};
        result[first.key] = first.value;
        rest.forEach((e) => { result[e[2].key] = e[2].value; });
        return result;
       }

item = key:id _ ":" _ value:literal { return {key: key, value: value}; }

id = chars:[a-zA-Z_]+ { return chars.join(""); }

quotation_mark = '"'
unescaped = [\x20-\x21\x23-\x5B\x5D-\u10FFFF]
escape = "\\"

HEXDIG = [0-9a-f]i