function [lambda] = p1lcurveopt(obj,lmin,lmax)
    lambda = fminbnd(@(x) -p1lcurvekappa(obj,x),lmin,lmax);
    disp(lambda);
end

