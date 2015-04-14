function features = stroke2FeatureVector1(s)
    %Number of Samples
    num_samples = size(s,1);
    s_original = s;

    %Normalize
    h_size = max(s(:,1))-min(s(:,1));
    v_size = max(s(:,2))-min(s(:,2));
    denom = v_size;
    if h_size > v_size
        denom = h_size;
    end
    denom = 1;
    s(:,1) = (s(:,1)-min(s(:,1)))/(denom); 
    s(:,2) = (s(:,2)-min(s(:,2)))/(denom); 

    %Resample
    rs = zeros(30,3);
    rs(:,1) = fResample(s(:,1),30);
    rs(:,2) = fResample(s(:,2),30);
    rs(:,3) = fResample(s(:,3),30);

    %Stroke Duration 
    stk_duration = max(s(:,3))-min(s(:,3));

    %Stroke Length
    stk_length = getStrokeLength(s_original);

    %Stroke Velocity
    stk_speed = zeros(29,1);
    for i=2:30
        stk_speed(i-1) = (1000*norm(rs(i,1:2)-rs(i-1,1:2)))/(rs(i,3)-rs(i-1,3));
    end

    %Stroke Curvature
    stk_curvature = zeros(28,1);
    for i=2:29
        % Get Vectors
        prev_vector = rs(i,1:2)-rs(i-1,1:2);
        next_vector = rs(i+1,1:2)-rs(i,1:2);
        prev_vector = prev_vector/norm(prev_vector);
        next_vector = next_vector/norm(next_vector);

        %Get Angle
        var_temp = dot(prev_vector,next_vector);
        if(var_temp>1)
            var_temp=1;
        else if(var_temp<-1)
            var_temp=-1;
        end
        stk_curvature(i-1) = (180/pi)*acos(var_temp);
    end

    features = zeros(30*2 + 29 + 28 + 1 + 1,1);

    %Set Feature Vector
    features(1:30) = rs(:,1);
    features(31:60) = rs(:,2);
    features(61:89) = stk_speed;
    features(90:117) = stk_curvature;
    features(118) = stk_length;
    features(119) = stk_duration;

end