function [writer, allStrokes] = readXMLUtil(filePath)

    try
        docNode = xmlread(fullfile(filePath));
        strokeSetElement = docNode.getElementsByTagName('StrokeSet').item(0);
        strokes = strokeSetElement.getElementsByTagName('Stroke');
        writer = char(docNode.getElementsByTagName('General').item(0).getElementsByTagName('Form').item(0).getAttribute('writerID'));
    
        allStrokes = cell(1, strokes.getLength+1);
        allStrokes{1} = writer;
        for i = 0:strokes.getLength-1
            thisStrokeCoordinates = strokes.item(i).getElementsByTagName('Point');
            startTime = str2num(strokes.item(i).getAttribute('start_time'));
            thisStrokeMatrix = zeros(thisStrokeCoordinates.getLength,3);
            for j = 0:thisStrokeCoordinates.getLength-1
                thisStrokeMatrix(j+1,:) = [str2num(thisStrokeCoordinates.item(j).getAttribute('x')),str2num(thisStrokeCoordinates.item(j).getAttribute('y')),1000*(str2num(thisStrokeCoordinates.item(j).getAttribute('time'))-startTime)];
            end
            allStrokes{i+2} = thisStrokeMatrix;
        end
        
    catch error
    end
end