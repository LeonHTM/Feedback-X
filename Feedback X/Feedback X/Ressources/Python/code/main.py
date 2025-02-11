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
    parser.add_argument("--upload_value", nargs='+', help="List of file paths to upload.")
    parser.add_argument("--topic_value", type=str, required=True, help="Topic Value.")
    parser.add_argument("--accounts_file_path", type=str, required=True, help="The path to the accounts file")
    parser.add_argument("--cookies_file_path", type=str, required=True, help="The path to the cookies file")
    parser.add_argument("--content_file_path", type=str, required=True, help="The path to the content file")
    parser.add_argument("--savesPath", type=str, required=True, help="The path to the saves folder")

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
        topic_value=args.topic_value,
        accounts_file_path=args.accounts_file_path,
        cookies_file_path=args.cookies_file_path,
        content_file_path=args.content_file_path,
        savesPath=args.savesPath
    )

if __name__ == "__main__":
    main()
