function index = Input_Split(xmin,xmax,g_up)

i = 1;
input_length = 6;
largestValue = 0;
index = 0;

while(i<input_length+1)
    range = xmax(i)-xmin(i);
    e = g_up(i)*range;
    if(e>largestValue)
        largestValue = e;
        index = i;
    end
    i = i+1;
end

