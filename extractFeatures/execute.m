function [] = execute(p1, p2, p3, s, e, select)

    %p1 = '../testing_cells/10'
    %p2 = '../trainFeatures1/'
    %p3 = '../testFeatures1/'
    for sample = [s:e]

        p = strcat(p1, sprintf('%03d',sample));
        directory = dir(p);
        fprintf('Extracting features for author with id: %d\n', sample);

        %% LOAD SESSIONS : 130
        if select == 1
            dim = 119;
        else
            dim = 143;
        end

        feat_matrix_train = zeros(0,dim);
        feat_matrix_test = zeros(0,dim);
        for i = 3:(length(directory))
            %Load Session
            session_name = directory(i).name;
            session_path = strcat(p,'/',session_name);
            [dum1, name_root, dum2] = fileparts(session_path);
            load(session_path);
            session = eval(name_root);

            %Iterate Strokes in Session
            for j = 2:length(session)
                inputStroke = session{j};
                %inputStroke(:,1) = smooth(inputStroke(:,1)); inputStroke(:,2) = smooth(inputStroke(:,2));
                ss = segmenter(inputStroke);
                for k = 1:length(ss)
                    sl = getStrokeLength(ss{k});
                    if sl < 50 || sl > 1500
                        continue;
                    end
                    if select == 1
                        thisFeatures = stroke2FeatureVector1(ss{k});
                    else
                        thisFeatures = stroke2FeatureVector2(ss{k});
                    end
                    %thisFeatures = stroke2FeatureVector1(ss{k});
                    if (i == (length(directory)))
                        feat_matrix_test = cat(1,feat_matrix_test, thisFeatures');
                    else
                        feat_matrix_train = cat(1,feat_matrix_train, thisFeatures');
                    end
                    
                end
            end    

            clear('session');
            clear(name_root);
        end

        %Saving
        S1.(strcat('feat_matrix_',sprintf('%03d',sample))) = feat_matrix_train;
        S2.(strcat('feat_matrix_',sprintf('%03d',sample))) = feat_matrix_test;
        save(strcat(p2, 'feat_matrix_',sprintf('%03d',sample),'.mat'), '-struct', 'S1')
        save(strcat(p3, 'feat_matrix_',sprintf('%03d',sample),'.mat'), '-struct', 'S2')
        clear('S1');
        clear('S2');
    end

end