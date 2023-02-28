clc
clear
clear all

N = input("Enter a number for the size of the map N,N: "); ... Getting size of the map N,N

x = 1; y = 1; ... user starts position 1,1 thats why x and y equal 1
z = N; t = N; ... Ghost starts position N,N z and t will keep ghost position

score_counter = 0; ...getting user points 
state = 0;   ...check and close the code

for j = 1:N    %filling the map with points and then they will be compared
    for k = 1:N
        position_point(j,k) = 1;
    end
end
position_point(1,1) = 0;


for i = 1:N^5

    for b = 1:N ...map
        for m = 1:N
            if x == b && y == m
                fprintf(" U ")
            elseif z == b && t == m
                fprintf(" G ")
            else
                fprintf(" * ")
            end   
        end
        fprintf("\n")
    end
    fprintf("\n")

    user_decision(i) = input("\nChoose your movement as up=(1), down=(2), right=(3)," + ...
            " left=(4), up-left=(5), up-right=(6), down-left=(7), down-right=(8): ");

    can_move = 1; ... it will use for user can or cant move


    if user_decision(i) == 1 && x > 1 ... otherwise it will pass the border 
        x = x - 1;
    elseif user_decision(i) == 2 && x < N 
        x = x + 1;
    elseif user_decision(i) == 3 && y < N 
        y = y + 1;
    elseif user_decision(i) == 4 && y > 1 
        y = y - 1;
    elseif user_decision(i) == 5 && x > 1 && y > 1
        x = x - 1;
        y = y - 1;
    elseif user_decision(i) == 6 && x > 1 && y < N 
        x = x - 1;
        y = y + 1;  
    elseif user_decision(i) == 7 &&  x < N && y > 1 
        x = x + 1;
        y = y - 1;
    elseif user_decision(i) == 8 && x < N && y < N 
        x = x + 1;
        y = y + 1;
    else
        fprintf("\nYou can not move because of the border. Please choose it again\n")
        can_move = 0;
    end

    if can_move == 1
        if x == z && y == t ...checking if ghost is there || (x+1 == z && y == t) || (x == z && y+1 == t) || (x == z && y-1 == t) || (x-1 == z && y-1 == t) || (x-1 == z && y+1 == t) || (x+1 == z && y-1 == t) || (x+1 == z && y+1 == t)
            can_move = 0;
            fprintf("You can not move because of the ghost. You will be eaten. Try another movement\n")
        else
            can_move = 1;
        end
    end

    if can_move == 1  ... if user can move will get point with comparing position_point

            score_counter = score_counter + position_point(x,y);
            position_point(x,y) = 0; ... after point eaten by user point will be deleted

            pythagoras(i,1) = (z-x-1)^2 + (t-y)^2; ... there are 8 possible movements for ghost, shortest one will be chose
            pythagoras(i,2) = (z-x+1)^2 + (t-y)^2;
            pythagoras(i,3) = (z-x)^2 + (t-y+1)^2;
            pythagoras(i,4) = (z-x)^2 + (t-y-1)^2;
            pythagoras(i,5) = (z-x-1)^2 + (t-y-1)^2;
            pythagoras(i,6) = (z-x-1)^2 + (t-y+1)^2;
            pythagoras(i,7) = (z-x+1)^2 + (t-y-1)^2;
            pythagoras(i,8) = (z-x+1)^2 + (t-y+1)^2;

            smallest_distance = pythagoras(i,1); ... chosing shortest position to the user
            for c = 1:8
                if smallest_distance > pythagoras(i,c)
                    smallest_distance = pythagoras(i,c);
                end
                if pythagoras(i,c) == 0
                    fprintf("\nYou are eaten by ghost your score is %d ",score_counter)
                    state = 31;
                    break
                end
            end

            if smallest_distance == pythagoras(i,1)
                z = z - 1;
            elseif smallest_distance == pythagoras(i,2)
                z = z + 1;
            elseif smallest_distance == pythagoras(i,3)
                t = t + 1;
            elseif smallest_distance == pythagoras(i,4)
                t = t - 1;
            elseif smallest_distance == pythagoras(i,5)
                z = z - 1;
                t = t - 1;
            elseif smallest_distance == pythagoras(i,6)
                z = z - 1;
                t = t + 1;
            elseif smallest_distance == pythagoras(i,7)
                z = z + 1;
                t = t - 1;
            elseif smallest_distance == pythagoras(i,8)
                z = z + 1;
                t = t + 1;
            end

            if score_counter == (N^2 - 1)  ... getting highest point
                fprintf("\nCongratulation you get max point %d",score_counter)
                state = 31;
                break
            end
    end

    if state == 31
        break
    end

end





