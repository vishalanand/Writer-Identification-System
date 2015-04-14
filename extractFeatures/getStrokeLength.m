function l = getStrokeLength(s)
    l = 0;
    for i = 2:size(s,1)
        prev_point = s(i-1,1:2);
        this_point = s(i,1:2);
        l = l + norm(this_point - prev_point);
    end
end