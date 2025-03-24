# Omfattande Problem

Syftet med det här projektet är att lösa och redovisa ett "omfattande problem" i gymnasiekursen Matematik 5.

## Omvandla tal i olika talbaser
> OMRÅDEN: Talteori, Kongruens NIVÅ: E-A TYP: Öppen

Skriv ett program som omvandlar tal i olika talbaser.
- (Enklast) Skriv ett program som tar ett tal i basen 10 som input, samt vilken bas man vill skriva om talet i, och returnerar talet i den nya basen.

- (Svårare) Skriv ett program som tar ett tal i en godtycklig bas a och omvandlar talet i en annan godtycklig bas b, där användaren själv kan välja baserna a och b, där 2 ≤ a, b ≤ 10 (eftersom vi saknar siffror för baser större än 10.)
- (Svårast) Som i förra uppgiften men tillåt nu baser större än 10 genom att använda bokstäver från alfabetet som siffror så att vi kan representera tal i baser större än 10.

För att denna uppgift ska komma upp i C/A-nivå behöver du förutom ovanstående tänka på att:
- Visa din matematiska förmåga genom att inte använda för många inbyggda funktioner.
- Välja någon ytterligare funktionalitet i programmet, tex att kunna hantera decimaltal.
- Tänka extra mycket på i din redovisning att visa den matematiska förståelse av programmet.

## Lösning

Lösningen till det här problemet är gjord som ett terminalprogram i `Ruby` och kan hantera:
- talbaser mellan 2-62 (0-9, A-Z, a-z)
- decimaltal avrundat till en utvald precission

### Användning

Starta programet:
```console
ruby main.rb
```

Använd `:` följt med en bokstav för att ändra inställningarna och stänga av programet:
- I/i - ändra basen av den inmatade siffran.
- O/o - ändra basen av den givna siffran.
- P/p - ändra precissionen av siffran i antal siffror efter punkten (avrundning till närmast `o^(-p)`)
- Q/q - avsluta programmet

Skriv in ett tall för att omvandla basen

Exempel:

```console
(I) Input base: 10; (O) Output base: 10; (P) Precission: 3; (Q) Quit
10
base(10) 10 is 10 in base(10)

(I) Input base: 10; (O) Output base: 2; (P) Precission: 3; (Q) Quit
2
base(10) 2 is 10 in base(2)

(I) Input base: 16; (O) Output base: 2; (P) Precission: 3; (Q) Quit
FF
base(16) FF is 11111111 in base(2)

(I) Input base: 2; (O) Output base: 10; (P) Precission: 3; (Q) Quit
.1
base(2) .1 is 0.5 in base(10)
```

### Beräkning

