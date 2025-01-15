import argparse
from cycles import cycles

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Run the duplication_cycle function with specified arguments.")
    parser.add_argument("--start_value", type=int, required=True, help="Starting value for the cycle.")
    parser.add_argument("--iteration_value", type=int, required=True, help="Iteration value for the cycle.")
    parser.add_argument("--submit_value", type=str, required=True, help="Submission value.")
    parser.add_argument("--title_value", type=str, required=True, help="Title value.")
    parser.add_argument("--path_value", type=str, required=True, help="Path value in a comma-separated format.")
    parser.add_argument("--headless_value", type=str, required=True, help="Headless value (True/False).")
    parser.add_argument("--upload_value", nargs='+', required=True, help="List of file paths to upload.")
    parser.add_argument("--area_value", type=str, required=True, help="Area value.")

    headless = False

    # Parse the arguments
    args = parser.parse_args()

    if args.headless_value == "True":
        headless = True

    # Initialize the cycles instance
    main = cycles()

    # Call the duplication_cycle function with parsed arguments
    main.duplication_cycle(
        start_value=args.start_value,
        iteration_value=args.iteration_value,
        submit_value=args.submit_value,
        title_value=args.title_value,
        path_value=args.path_value,
        headless_value=headless,
        upload_value=args.upload_value,
        area_value=args.area_value,
    )

if __name__ == "__main__":
    main()
