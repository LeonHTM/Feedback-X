import argparse
from tokenize import String
from cycles import cycles




def main():
    # Create an ArgumentParser object
    parser = argparse.ArgumentParser(description="Run the login_cycle with specified parameters.")
    
    # Add arguments for all the parameters of login_cycle
    parser.add_argument("--start_value", type=int, required=True, help="The starting value")
    parser.add_argument("--iteration_value", type=int, required=True, help="The iteration value")
    parser.add_argument("--chill_value", type=int, required=True, help="The chill value (default: 1)")
    parser.add_argument("--headless_value", type=str)
    
    headless = False
    
    # Parse the command-line arguments
    args = parser.parse_args()

    if args.headless_value == "True":
        headless = True
    
    # Create an instance of the cycles class
    main = cycles()
    
    # Run the login_cycle function with parsed arguments
    main.login_cycle(
        start_value=args.start_value,
        iteration_value=args.iteration_value,
        chill_value=args.chill_value,
        headless_value= headless
    )

if __name__ == "__main__":
    main()
