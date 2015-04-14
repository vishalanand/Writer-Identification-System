function [] = readXML(path1, path2)


    %path1 = '../data/original-part/';
    %path2 = '../training_cells/';
    l1Dir = dir(path1);
    for k1=3:length(l1Dir)
        p2 = strcat(path1, l1Dir(k1).name,'/');
        l2Dir = dir(p2);
        for k2=3:length(l2Dir)
            p3 = strcat(p2,l2Dir(k2).name,'/');
            l3Dir = dir(p3);
            for k3=3:length(l3Dir)
                p4 = strcat(p3,l3Dir(k3).name);
                try
                    %Read XML File
                    [thisWriter, thisCell] = readXMLUtil(p4);

                    %Directory Issues
                    p5 = strcat(path2, thisWriter);
                    if exist(p5,'dir') == 0
                        mkdir(p5);
                    end
                    thisFileName = strcat('session_',int2str(length(dir(p5))-1));
                    savePath = strcat(p5,'/',thisFileName,'.mat')

                    %Saving
                    S.(thisFileName) = thisCell;                
                    save(savePath,'-struct','S');            

                    %Clearing Variables
                    clear('S');
                    clear('thisWriter');
                    clear('thisCell');
                catch error
                    disp('Continuing...');
                end
            end
        end
    end
end