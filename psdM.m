% Check sign of prinicipal minor
function psd = psdM(hessian)

    if hessian(1,1) >= 0 && det(hessian) >= 0
        psd = true;
    else
        psd = false;
    end
    
end