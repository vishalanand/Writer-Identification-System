function rStroke = fResample(stroke,num)
    old_length = size(stroke,1);
    new_length = num;
    rStroke = zeros(0,size(stroke,2));
    for i=0:new_length-1
        position = (i*1.0*(old_length-1))/(new_length-1);
        if floor(position) ~= position
            floorp = floor(position);
            ceilp = ceil(position);
            prev_segment = position-floorp;
            next_segment = ceilp - position;
            rStroke(i+1,:) = (next_segment*stroke(floorp+1,:) + prev_segment*stroke(ceilp+1,:));
        else
            rStroke(i+1,:) = stroke(position+1,:);
        end
    end
end
