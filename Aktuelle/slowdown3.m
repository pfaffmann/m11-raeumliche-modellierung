function val=slowdown3(x)
%Nach den Angegebenen Tagen wird der angegebene Prozentsatz der urspr�nglichen Rate genommen
%Prozentsatz wird durch den Faktor "val" definiert

if x<25 val=1;   
%Zwischen Tag 25 (Tag der Kontaktverbote) und Tag 33 besteht �bergangszeit
%d.h. Menschen, die sich vor den Kontaktverboten infiziert haben, werden dann erst erfasst   
  elseif x<33
  val=0.75;
  
%Ersten 10 Tage der Kontaktverbote mit zunaechst weniger einschneidenen Ma�nahmen, darueber hinaus
%haben sich nicht alle Menschen daran gehalten  
  elseif x<42
  val=0.4;
  
%Striktere Ma�nahmen zur Eindaemmung und Umdenken bei der Bevoelkerung  durch Pressemitteilungen aus Italien

  elseif x<69
  val=0.165;

%Weniger aktive Faelle und Weiterfuerhung der Beschraenkungen
  
elseif x<80
  val=0.09;


endif
%Beispielhafte Lockerung der Ma�nahmen ab Tag 80, die die Infektionsrate wieder
%auf 50 % der Basisinfektionsrate erhoeht
%(um den Effekt der Lockerung zu beobachten)
if x>=80 val=0.5; endif
endfunction