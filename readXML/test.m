function allWriters = test(p1)

    allWriters = containers.Map('KeyType','char','ValueType','int32');
    %p1 = '/home/va/Writer-Identification-System/data/original/';
    l1Dir = dir(p1);
    for k1=3:length(l1Dir)
        p2 = strcat(p1, l1Dir(k1).name,'/');
        l2Dir = dir(p2);
        for k2=3:length(l2Dir)
            p3 = strcat(p2,l2Dir(k2).name,'/');
            l3Dir = dir(p3);
            for k3=3:length(l3Dir)
                p4 = strcat(p3,l3Dir(k3).name);
                disp(p4);
                try
                    docNode = xmlread(fullfile(p4));
                    writer = char(docNode.getElementsByTagName('General').item(0).getElementsByTagName('Form').item(0).getAttribute('writerID'));
                    if(isKey(allWriters, writer))
                        allWriters(writer) = allWriters(writer) + 1;
                    else
                        allWriters(writer) = 1;
                    end
                    
                catch error
                    disp('Continuing...');
                end
            end
        end
    end
end