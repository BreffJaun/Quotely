#  TASK 1.2

##Zu 1:
- Füge ich den Parameter 5 hinzu und setze den Wert auf 5, erhalte ich anstatt eines Datensatzes, 5 zurück.
- Setze ich kein Limit erhalte ich 1 Datensatz zurück
- Als String kommt wieder nur 1 Datensatz zurück, weil "limit" nicht als Parameter limit erkannt wird und somit auf den default Wert zurückgegriffen wird.

##Zu 2:
- Ja! Deutsch, also DE ist default Wert.
- Es scheint als würde nur DE und EN gehen


##Zu 3:
- Nein, er hat keinen default Wert, weil bei falscher Eingabe auf keinen Wert zurückgegriffen wird.

##Zu 4:
- Der Zugriff auf den Parameter author ist nicht autorisiert.
=> auch nicht mit 
https://api.syntax-institut.de/quotes?limit=5&language=DE&category=friendship&author=Anne%20Frank
