function belongsToCurrentFolder(currentPath, filePath) {
	var regex = new RegExp("^" + currentPath + "/");
	
	return filePath.replace(regex, "").split("/").length == 1
}

belongsToCurrentFolder:w
