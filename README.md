# OctoChallengesShim

Behebt einen Lua-Fehler im Zielrahmen von OctoWoW (WoW 1.12).

## Problem
OctoWoW ist ein Turtle-WoW-Fork und hat dessen `Interface\FrameXML\TargetFrame.lua` übernommen. Diese Datei greift auf die globale Tabelle `Turtle_ChallengesCache` zu, die auf Turtle WoW das Addon `Turtle_General` bereitstellt. OctoWoW liefert dieses Addon nicht mit, daher kommt beim Anvisieren:

- ohne Tabelle: `attempt to index global 'Turtle_ChallengesCache'`
- mit leerer Tabelle: `attempt to index field '?'`, weil zwei Ebenen tief zugegriffen wird

## Lösung
Das Addon legt `Turtle_ChallengesCache` an, falls sie fehlt. Eine Metatabelle liefert für jeden unbekannten Schlüssel dieselbe leere Tabelle zurück, sodass auch der zweite Zugriff sauber `nil` ergibt. Es wächst kein Speicher.

## Einstellungen
Keine.

## Entfernen
Ordner löschen.
