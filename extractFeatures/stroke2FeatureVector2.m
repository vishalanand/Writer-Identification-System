function features = stroke2FeatureVector2(s)
	%Number of Samples
    num_samples = size(s,1);
    s_original = s;

   	%Resample
    rs = zeros(30,3);
    rs(:,1) = fResample(s(:,1),30);
    rs(:,2) = fResample(s(:,2),30);
    rs(:,3) = fResample(s(:,3),30);

    %Writing Direction
    cosVals = zeros(29,1);
    sinVals = zeros(29,1);
    for i=2:30
    	l = norm(rs(i,1:2)-rs(i-1,1:2));
    	cosVals(i-1) = (rs(i,1)-rs(i-1,1))/l;
    	sinVals(i-1) = (rs(i,2)-rs(i-1,2))/l;
    end

    %Stroke Velocity
    stk_speed = zeros(29,1);
    for i=2:30
        stk_speed(i-1) = (1000*norm(rs(i,1:2)-rs(i-1,1:2)))/(rs(i,3)-rs(i-1,3));
    end

    %Stroke Curvature
    cosCurv = zeros(28,1);
    sinCurv = zeros(28,1);
    for i=2:29
        cosCurv(i-1) = cosVals(i-1)*cosVals(i) + sinVals(i-1)*sinVals(i);
        sinCurv(i-1) = cosVals(i-1)*sinVals(i) - sinVals(i-1)*cosVals(i);
    end

    features = zeros(143,1);

    %Set Feature Vector
    features(1:29) = cosVals;
    features(30:58) = sinVals;
    features(59:87) = stk_speed;
    features(88:115) = cosCurv;
    features(116:143) = sinCurv;
end