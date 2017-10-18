%  Cart_Pole:  Takes an action (0 or 1) and the current values of the
%  four state variables and updates their values by estimating the state
%  TAU seconds later.

function [x,x_dot,theta,theta_dot]=Cart_Pole(action,x,x_dot,theta,theta_dot)

% Parameters for simulation

g=9.8;              %Gravity
Mass_Cart=1.0;      %Mass of the cart is assumed to be 1Kg
Mass_Pole=0.1;      %Mass of the pole is assumed to be 0.1Kg
Total_Mass=Mass_Cart+Mass_Pole;
Length=0.5;         %Half of the length of the pole 
PoleMass_Length=Mass_Pole*Length;
Force_Mag=10.0;
Tau=0.02;           %Time interval for updating the values
Fourthirds=1.3333333;


if action>0,
    force=Force_Mag;
else
    force=-Force_Mag;
end

temp = (force + PoleMass_Length *theta_dot * theta_dot * sin(theta))/ Total_Mass;

thetaacc = (g * sin(theta) - cos(theta)* temp)/ (Length * (Fourthirds - Mass_Pole * cos(theta) * cos(theta) / Total_Mass));

xacc  = temp - PoleMass_Length * thetaacc* cos(theta) / Total_Mass;
 
% Update the four state variables, using Euler's method.
x=x+Tau*x_dot;
x_dot=x_dot+Tau*xacc;
theta=theta+Tau*theta_dot;
theta_dot=theta_dot+Tau*thetaacc;