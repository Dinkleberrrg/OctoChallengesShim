-- OctoWoW ist ein Turtle-Fork und hat dessen Interface\FrameXML\TargetFrame.lua
-- uebernommen. Die Datei greift auf die globale Tabelle Turtle_ChallengesCache zu,
-- die auf Turtle vom Addon Turtle_General kommt (dort im Client-MPQ). Octo liefert
-- das Addon nicht mit.
--
-- Beobachtetes Fehlerbild, in zwei Stufen:
--   1. ohne Shim:            "attempt to index global 'Turtle_ChallengesCache'"
--      -> der Code macht Turtle_ChallengesCache[X]
--   2. mit Turtle_ChallengesCache = {}:  "attempt to index field '?'"
--      -> er macht Turtle_ChallengesCache[X][Y], und [X] war nil
--
-- Also muss die erste Ebene eine Tabelle liefern statt nil. Genau das macht die
-- Metatabelle unten: jeder unbekannte Schluessel gibt EINE gemeinsame leere Tabelle
-- zurueck (kein Speicherwachstum), deren Felder dann sauber nil sind.
--
-- Entfernen: Ordner loeschen.

local EMPTY = {}

if not Turtle_ChallengesCache then
    Turtle_ChallengesCache = setmetatable({}, {
        __index = function() return EMPTY end
    })
end
