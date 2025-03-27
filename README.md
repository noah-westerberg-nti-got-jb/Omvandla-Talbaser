# Omfattande Problem

Syftet med det här projektet är att lösa och redovisa ett "omfattande problem" i gymnasiekursen Matematik 5.

## Omvandla tal i olika talbaser
> OMRÅDEN: Talteori, Kongruens NIVÅ: E-A TYP: Öppen

Skriv ett program som omvandlar tal i olika talbaser.
- (Enklast) Skriv ett program som tar ett tal i basen 10 som input, samt vilken bas man vill skriva om talet i, och returnerar talet i den nya basen.

- (Svårare) Skriv ett program som tar ett tal i en godtycklig bas a och omvandlar talet till en annan godtycklig bas b, där användaren själv kan välja baserna a och b, där 2 ≤ a, b ≤ 10 (eftersom vi saknar siffror för baser större än 10).
- (Svårast) Som i förra uppgiften men tillåt nu baser större än 10 genom att använda bokstäver från alfabetet som siffror så att vi kan representera tal i baser större än 10.

För att denna uppgift ska komma upp i C/A-nivå behöver du förutom ovanstående tänka på att:
- Visa din matematiska förmåga genom att inte använda för många inbyggda funktioner.
- Välja någon ytterligare funktionalitet i programmet, t.ex. att kunna hantera decimaltal.
- Tänka extra mycket på att i din redovisning visa den matematiska förståelsen av programmet.

## Lösning

Lösningen till det här problemet är gjord som ett terminalprogram i `Ruby` och kan hantera:
- talbaser mellan 2-62 (0-9, A-Z, a-z)
- decimaltal avrundat till en utvald precision

### Användning av programmet

1. Starta programmet:
```console
ruby main.rb
```

2. Använd `:` följt av en bokstav för att ändra inställningarna eller stänga av programmet:
   - I/i - ändra basen av den inmatade siffran.
   - O/o - ändra basen av den givna siffran.
   - P/p - ändra precisionen av siffran i antal siffror efter punkten (avrundning till närmast <code>ny-bas<sup>-p</sup></code>).
   - Q/q - avsluta programmet.

3. Skriv in ett tal för att omvandla basen.

Exempel:

```console
(I) Input base: 10; (O) Output base: 10; (P) Precision: 3; (Q) Quit
10
base(10) 10 is 10 in base(10)
```
```console
(I) Input base: 10; (O) Output base: 2; (P) Precision: 3; (Q) Quit
2
base(10) 2 is 10 in base(2)
```
```console
(I) Input base: 16; (O) Output base: 2; (P) Precision: 3; (Q) Quit
FF
base(16) FF is 11111111 in base(2)
```
```console
(I) Input base: 2; (O) Output base: 10; (P) Precision: 3; (Q) Quit
.1
base(2) .1 is 0.5 in base(10)
```

### Beräkning

Programmets huvudfunktion är:
```ruby
convert_base(num_string, old_base, new_base, max_decimal_places)
```

där `num_string` är strängen av siffran som ska konverteras, `old_base` är ett heltal mellan 2 - 62 och är basen på inmatningstalet, `new_base` är ett heltal mellan 2 - 62 och är basen på talet som funktionen ger ut, och `max_decimal_places` är ett heltal som anger hur många siffror efter decimalpunkten som ska användas.

#### Omvandla en siffra till och från en karaktär

För att kunna byta mellan siffror och karaktärer som representerar siffrorna (t.ex. 1 => '1', 10 => 'A', osv.) så använder programmet en funktion (`char_to_num`) som använder karaktärens ASCII-värde för att ta fram siffran den representerar och en funktion (`num_to_char`) som använder en ordnad lista med alla karaktärer för att ta fram en karaktär på en specifik plats.

#### Omvandla talet till en siffra som datorn kan använda

Det första som görs är att strängen som matas in konverteras till en siffra som datorn kan använda. 

1. Det görs genom att först dela upp talet i en heltalsdel och en decimaltalsdel, vilket görs genom att dela talet på en eventuell punkt (.) som finns.

2. Sedan itereras de uppdelade strängarna igenom för att lägga till varje siffra i talet som datorn kan använda:
    ```ruby
    integer_string.each_char do |char|
        integer *= base
        integer += char_to_num(char)
    end
    ```
    Varje gång talet multipliceras med basen frigörs en ny nolla där nästa tal kan läggas. För decimal-delen är det nästan samma, men är omvänt eftersom talet delas på basen istället för att multipliceras:
    ```ruby
    decimal_string.reverse.each_char do |char|
        decimal += char_to_num(char)
        decimal /= base
    end
    ```
3. Till sist sammanläggs de beräknade heltalet och decimaltalet till ett tal som sedan kan omvandlas.

#### Beräkna den nya siffran

Efter att talet som ska omvandlas har tagits fram kan det börja omvandlas.

1. Det första steget är att beräkna hur många heltalskaraktärer som det nya talet som mest behöver för att representera talet som ska omvandlas. Det kan tas fram genom olikheten: 
    <div>
    <code>
    ny-bas<sup>n</sup>
    &ge;
    tal-som-ska-omvandlas
    </code>
    </div>

    > *Antalet decimaltalskaraktärer är bestämt av precisionen som bestäms av användaren.*

2. Sedan itererar programmet från den högsta till den lägsta positionen i det nya talet (plus en till för att kunna avgöra om den sista siffran behöver avrundas upp eller inte).
    ```ruby
    while new_num_length >= -(max_decimal_places + 1)
        position_number = (num / (new_base ** new_num_length)).to_i
        num_array.append(position_number)
        num -= position_number * (new_base ** new_num_length)
        new_num_length -= 1
    end
    ```

    Först beräknas siffran som ska vara i positionen genom att ta heltalet avrundat neråt av talet delat på värdet av platsen, och läggs till i en lista med alla platsernas tal. Sedan decrementeras talet med resten av divisionen.
    > *Att använda modulo-operatorn `%` ledde till att tal beräknades fel. Jag misstänker att det har något med hur den interagerar med icke-heltal eftersom det fungerade att använda operatorn för bara heltal.*

#### Formatera den nya siffran

Innan talen från listan sätts ihop och skickas ut behöver de formateras.

1. När alla positioner är beräknade undersöks först om det sista talet borde avrundas uppåt eller neråt:
    ```ruby
    if num_array[-1] >= new_base / 2
        num_array[-2] += 1
        num_array[-1] = 0
    end
    ```
2. Efter det itereras alla tal igenom för att se om något tal behöver flyttas upp:
    ```ruby
    i = 0
    while i < num_array.length
        if num_array[i] >= new_base
            num_array[i-1] += 1
            num_array[i] = num_array[i] - new_base
            i -= 1
            next
        end
        i += 1
    end
    ```
3. Sedan matas alla tal in i en sträng:
   ```ruby 
    result = ""
    i = 0
    while i < num_array.length || i <= integer_length
        if num_array.length > integer_length && i == integer_length
            result += num_to_char(num_array[i]) + "."
        elsif i >= (num_array.length - 1)
            result += "0"
        else
            result += num_to_char(num_array[i])
        end
        i += 1
    end
   ```
4. Innan det omvandlade talet returneras så tas eventuella nollor bort från ändarna av strängen:
    ```ruby
    result = result[1..-1] while result[0] == "0" && result[1] != "."
    if result.include?(".")
        result = result[0..-2] while result[-1] == "0"
        result = result[0..-2] if result[-1] == "."
    end
    ```

Efter alla steg returneras den omvandlade siffran:
```ruby
return result
```

#### Felkällor/Förbättringsområden

En eventuell felkälla med beräkningsmetoden är att talen som beräknas är beroende av datorns flyttalsprecision eftersom det inmatade talet först omvandlas till ett tal som datorn kan använda. Det hade möjligtvis kunnat åtgärdas genom att omvandla direkt från den ena strängen till den andra, men jag är inte säker på hur det hade gått till, eftersom jag baserade den här beräkningsmetoden på den som visades i matteboken *Matematik 5000 5* (s.80-81) som bara använder vanliga tal som går att använda med matematiska operatorer.