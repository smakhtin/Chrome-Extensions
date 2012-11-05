#Collecting all bookmarks and exporting to JSON

data = null
jsonData = ""

parseData = (bookmarksTree) -> 
	console.log "Parsed!"
	data = bookmarksTree
	jsonData = JSON.stringify bookmarksTree
	bookmarksTree

chrome.bookmarks.getTree parseData

#Writing JSON to disk

onInitiFileSystem = (fileSystem) ->
	console.log "File System initialiased"
	
	fileSystem.root.getFile 'bookmarks.json', create:true, (fileEntry) ->
		url = fileEntry.toURL()
		fileURLDiv = document.getElementById "fileURL"
		fileURLDiv.appendChild document.createTextNode url
		console.log url
		fileEntry.createWriter (fileWriter) ->
			fileWriter.onwriteend = (e) ->
				console.log "Write Completed"

			fileWriter.onerror = (e) ->
				console.log "Write Failed: " + e.toString()

			blob = new Blob([jsonData], type: "text/plain")

			fileWriter.write blob
		, errorHandler
	, errorHandler

errorHandler = (error) ->
	console.log error.code

#5mb quota
quota = 5 * 1024 * 1024
window.webkitRequestFileSystem window.TEMPORARY, quota, onInitiFileSystem, errorHandler