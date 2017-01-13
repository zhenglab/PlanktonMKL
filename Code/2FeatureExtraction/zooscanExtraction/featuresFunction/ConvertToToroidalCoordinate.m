function [newValue] = ConvertToToroidalCoordinate(value, maxValue)

    if value > maxValue
        newValue = (value - maxValue);
    elseif value < 1
        newValue = (value + maxValue);
    else 
        newValue = value;
    end
			
end