{
var others = [];

 function extractList(list, index) {
    var headings = [], italics = [], bolds= [], i;
	console.log(list);
    
    list.forEach(item => {
      if (item.heading)
       headings.push(item.heading);
      if (item.bold)
       bolds.push(item.bold);
      if (item.italic)
       italics.push(item.italic);  
    });

    return {
     bolds: bolds,
     headings: headings,
     italics: italics,
    };
 }
}

start = md:Markdown+ { return extractList(md); }

Markdown = EndOfLine / Heading / Space / Bold / Italic

Heading
  = "#"+ text:AnyText+ Space? {
    return {
     heading: text.join("")
    }
}

Italic
  = (AnyText+)? star text:AnyText+ Space? star {
    return {
     italic: text.join("")
    }
}

Bold
  = (AnyText+)? (star star) text:AnyText+ Space? (star star) {
    return {
     bold: text.join("")
    }
}

AnyText = [\x20-\x27] / [\x2B-\x40] / [\x41-\x5A] / [\x61-\x7A] / nonascii
//AnyText = [a-zA-Z0-9 ]

Digit1_9      = [1-9]
nonascii = [\x80-\uFFFF]
star = [\x2A]
EndOfLine = ('\r\n' / '\n' / '\r')+
Space = ' '+ / '\t' / EndOfLine