with Ada.Text_IO; 
with Ada.Calendar.Delays; 

procedure Donut is
    -- Declare constants and types
    subtype Index_Type is Integer range 0 .. 1759;
    type Float_Array is array (Index_Type) of Float;
    type Char_Array is array (Index_Type) of Character;
    type Characters_Array is array (Integer range 0..11) of Character;

    -- Declare variables
    Z : Float_Array := (others => 0.0);
    B : Char_Array := (others => ' ');
    Char_String : Characters_Array := ('.', ',', '-', '~', ':', ';', '=', '!', '*', '#', '$', '@');

    A, E, C, D, F, G, H, N : Float := 0.0;
    G_Val, H_Val : Float;
    A_Val, T_Val, D_Val : Float;
    X, Y, O : Integer;

    -- Declare macros/functions
    procedure Rotate (T : Float; X : in out Float; Y : in out Float) is
        F : Float;
    begin
        F := X;
        X := X - (T * Y);
        Y := Y + (T * F);
        F := (3.0 - X * X - Y * Y) / 2.0;
        X := X * F;
        Y := Y * F;
    end Rotate;

begin
    -- Initialize variables
    E := 1.0;
    C := 1.0;
    D := 0.0;

    loop
        -- Clear buffers
        for I in B'Range loop
            B(I) := ' ';
        end loop;

        for I in Z'Range loop
            Z(I) := 0.0;
        end loop;

        -- Initialize rotational values
        G := 0.0;
        H := 1.0;

        -- Main loop
        for J in 0 .. 89 loop
            G_Val := 0.0;
            H_Val := 1.0;

            for I in 0 .. 313 loop
                A_Val := H + 2.0;
                D_Val := 1.0 / (G_Val * A_Val * A + G * E + 5.0);

                T_Val := G_Val * A_Val * E - G * A;
                X := Integer(40.0 + 30.0 * D_Val * (H_Val * A_Val * D - T_Val * C));
                Y := Integer(12.0 + 15.0 * D_Val * (H_Val * A_Val * C + T_Val * D));

                O := X + 80 * Y;
                N := 8.0 * ((G * A - G_Val * H * E) * D - G_Val * H * A - G * E - H_Val * H * C);

                if Y > 0 and then 
                        Y < 22 and then 
                        X > 0 and then 
                        X < 80 and then 
                        D_Val > Z(O) then
                    Z(O) := D_Val;
                    declare
                        Safe_Index : Integer;
                    begin
                        if Integer(N) > 0 then 
                            Safe_Index := Integer(N); 
                        else 
                            Safe_Index := 0;
                        end if;
                        B (O) := Char_String(Safe_Index); 
                    end;
                end if;

                Rotate(0.02, H_Val, G_Val);
            end loop;

            Rotate(0.07, H, G);
        end loop;

        -- Output result
        for K in 0 .. 1760 loop
            if (K mod 80) = 0 then
                Ada.Text_IO.New_Line;
            else
                Ada.Text_IO.Put(B(K));
            end if;
        end loop;

        -- Perform final rotations
        Rotate(0.04, E, A);
        Rotate(0.02, D, C);

        -- Delay for smooth animation
        --  Ada.Calendar.Delays.Delay_For(0.015); 
        Ada.Calendar.Delays.Delay_For(0.06);
    end loop;
end Donut;
