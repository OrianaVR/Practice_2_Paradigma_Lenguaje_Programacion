% Base de datos de vehículos
% vehicle(Brand, Reference, Type, Price, Year).

vehicle(toyota, '4runner', suv, 40000, 2020). 
vehicle(toyota, corolla, sedan, 25000, 2017). 
vehicle(toyota, tundra, pickup, 65000, 2018).
vehicle(ford, fiesta, sedan, 27500, 2023).
vehicle(ford, ecosport, suv, 32000, 2019). 
vehicle(ford, mustang, sport, 76000, 1964). 
vehicle(chevrolet, camaro, sport, 88000, 1966). 
vehicle(nissan, navara, pickup, 58000, 2024). 
vehicle(nissan, qashqai, suv, 78000, 2025). 
vehicle(chevrolet, malibu, sedan, 37600, 2008). 
vehicle(nissan, kicks, suv, 35000, 2023).

meet_budget(Reference, BudgetMax) :-
	vehicle(_, Reference, _, Price, _),
	Price =< BudgetMax.

list_Toyota(Results):-
findall(Ref-Type-Price-Year, vehicle(toyota, Ref, Type, Price, Year), Results).

list_Ford(Results):-
findall(Ref-Type-Price-Year, vehicle(ford, Ref, Type, Price, Year), Results).

list_Nissan(Results):-
findall(Ref-Type-Price-Year, vehicle(nissan, Ref, Type, Price, Year), Results).


report(Brand, Type, Budget, Result) :-
    setof(vehicle(Brand, Ref, Type, Price, Year), (vehicle(Brand, Ref, Type, Price, Year), Price =< Budget), Cars),
    
    sum_prices(Cars, 0, Total),
    (   Total =< 1000000
    ->  Result = Cars
    ;   trim_to_limit(Cars, 1000000, [], Result)
    ).

sum_prices([], Total, Total).
sum_prices([vehicle(_, _, _, P, _)|Rest], Acc, Total) :-
    NewAcc is Acc + P,
    sum_prices(Rest, NewAcc, Total).

trim_to_limit([], _, Result, Result).
trim_to_limit([V|Rest], Limit, Acc, Result) :-
    V = vehicle(_, _, _, P, _),
    (   Limit >= P
    ->  NewLimit is Limit - P,
        trim_to_limit(Rest, NewLimit, [V|Acc], Result)
    ;   trim_to_limit(Rest, Limit, Acc, Result)
    ).