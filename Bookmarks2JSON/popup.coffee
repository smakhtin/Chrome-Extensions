data = null
jsonData = ""

parseData = (bookmarksTree) -> 
	console.log "Parsed!"
	data = bookmarksTree
	jsonData = JSON.stringify bookmarksTree
	console.log jsonData 
	bookmarksTree

chrome.bookmarks.getTree parseData