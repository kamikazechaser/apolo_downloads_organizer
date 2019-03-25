-- This script organizes files inside your Downloads folder into respective folders holding files of similar type

require 'apolo':as_global()

-- file types groups table with their respective extensions
local extensions = {
    documents = {
        '.pdf', '.txt', '.xlsx', '.pptx', '.docx', '.rtf'
    },
    videos = {
        '.mkv', '.mp4', '.avi', '.flv', '.webm'
    },
    compressed = {
        '.zip', '.rar', '.7z', '.iso'
    },
    images = {
        '.png', '.jpg', '.jpeg',
    },
    music = {
        '.mp3', '.flac', '.ogg'
    },
    programs = {
        '.exe', '.deb'
    }
}

-- get downloads dir path in windows or linux OS
if type(E.HOMEPATH) == 'string' then
    downloadsDir = 'C:' .. E.HOMEPATH .. '/Downloads'
else
    downloadsDir = E.HOME .. '/Downloads'
end

-- change directory
chdir(downloadsDir)

-- create the needed directories
function createDirs()
    for keys in pairs(extensions) do
        mkdir(keys)
    end
end

createDirs()

-- move files into their respective folders
function moveFiles(fileGroup, fileTable)
    for _, fileExtension in pairs(fileTable) do
        local matchedFiles = glob('*' ..fileExtension)

        for _, matchedFile in pairs(matchedFiles) do
            move(matchedFile, current() .. '/' .. fileGroup .. '/' .. matchedFile)
        end
    end
end

for key in pairs(extensions) do
    moveFiles(key, extensions[key])
end