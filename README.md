#RLE Dekompression und Kompression von Dateien

Die Lauflängencodierung (engl. run length encoding, kurz RLE) ist eine einfache Kompressions- technik für Dateien, bei der jede Zeichenfolge, die aus mehr als zwei gleichen Zeichen besteht, durch das erste Zeichen und die Länge der Folge codiert wird.
Implementieren Sie eine einfache Variante dieses Verfahrens in Form eines Filterprogramms RLE, das Textdateien, die nur Groß- und Kleinbuchstaben, Satz- und das Leerzeichen (aber keine Ziffern) enthalten, komprimieren und wieder dekomprimieren kann. Ihr Filterprogramm muss folgende Auf- rufmöglichkeiten von der Kommandozeile aus bieten (die Metasymbole [...] und ...|... stehen für Option bzw. Alternativen):


  ##RLE [ -c | -d ] [inFile] [outFile]

Bedeutung der Parameter:
-c die Eingabedatei soll komprimiert werden (Standardannahme), -d die Eingabedatei soll dekomprimiert werden,
inFile Name der Eingabedatei, sonst Standardeingabe (input) und outFile Name der Ausgabedatei, sonst Standardausgabe(output).
