% Set structure-file, file of common data and additional paths
function paths
    folder = fileparts(which(matlab.desktop.editor.getActiveFilename)); 
    addpath(genpath(folder));
end
