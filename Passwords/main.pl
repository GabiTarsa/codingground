#!/usr/bin/perl

&init_words;
@password = getpwuid($<); #get password
$name = $password[5]; #get the name
$name =~ s/,.*//; #throw everything after first comma
$original_name = $name;

if ($name =~ /^randal\b/i) {
    print "Hello, Randal!"
} else {
    print "Hello $original_name";
    print "password: ";
    $guess = <STDIN>;
    chop($guess);
    while (! &good_word($name, $guess)) {
        print "Wrong password!!! \n password: ";
        $guess = <STDIN>;
        chop($guess);
    }
}

sub init_words {
  while ($filename = <*.secret>) {
    open (WORDLIST, $filename);
    if (-M WORDLIST < 7) {
      while ($name = <WORDLIST>) {
        #print "Enter loop";
        chop($name);
        #print "name=$name\n";
        $word = <WORDLIST>;
        chop($word);
        #print "word=$word\n";
        $words{$name} = $word;
        #print "words= $words{$name}\n";
      }
    }
    else {
      rename($filename,"$filename.old")
    }
    close(WORDLIST);
  }
}

sub good_word {
    local($somename, $someguess) = @_;
    $somename =~ s/\W.*//; #delete everything after first word
    $someone =~ tr/A-Z/a-z/; #lowercase everything
    if ($somename eq "randal") {
        1;
    } elsif(($words{$somename} || "groucho") eq $someguess) {
        1;
    } else {
        print("Send a mail");   
    }
}
        
    
    
    
    
    
    
