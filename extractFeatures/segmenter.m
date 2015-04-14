function ss = segmenter(bs)
    this_stroke_start = 1;
    stroke_cnt = 1;
    ss{1} = bs;
    if size(bs,1)<3
        return
    end
    
    for i = 2:(length(bs)-1)
        % Get Vectors
        prev_vector = bs(i,1:2)-bs(i-1,1:2);
        next_vector = bs(i+1,1:2)-bs(i,1:2);
        prev_vector = prev_vector/norm(prev_vector);
        next_vector = next_vector/norm(next_vector);
        
        %Get Angle
        angle = (180/pi)*acos(dot(prev_vector,next_vector));
        
        %Check and Build Stroke
        if sign(prev_vector(2))~=sign(next_vector(2))
%         if angle > 90
            this_stroke_end = i;
            ss{stroke_cnt} = bs(this_stroke_start:this_stroke_end,:);
            stroke_cnt = stroke_cnt + 1;
            this_stroke_start = i+1;
        end            
    end
    ss{stroke_cnt} = bs(this_stroke_start:length(bs),:);
end