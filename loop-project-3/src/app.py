def calculate_total(items):
    # TODO: handle empty list without crashing
    total = 0
    for item in items:
        total += item["price"]
    return total


def send_email(to, subject, body):
    # TODO: add retry logic if the SMTP server is down
    print(f"Sending email to {to}")
    # TODO: validate item prices are not negative
