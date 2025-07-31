import 'package:flutter/material.dart';

class RatingsPage extends StatefulWidget {
  final String userName;

  const RatingsPage({super.key, required this.userName});

  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  List<int> ratingCounts = [0, 0, 0, 0, 0];
  final List<Map<String, dynamic>> reviews = [];

  int get totalReviews => ratingCounts.reduce((a, b) => a + b);

  double calculateAverage() {
    int totalScore = 0;
    for (int i = 0; i < ratingCounts.length; i++) {
      totalScore += (5 - i) * ratingCounts[i];
    }
    return totalReviews == 0 ? 0 : totalScore / totalReviews;
  }

  void addReview(double rating, String comment) {
    setState(() {
      reviews.insert(0, {
        "name": widget.userName,
        "rating": rating,
        "comment": comment,
      });
      ratingCounts[5 - rating.round()]++;
    });
  }

  void showReviewSheet() {
    double selectedRating = 5.0;
    final TextEditingController reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16),
          child: StatefulBuilder(builder: (context, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Write a Review",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 32,
                      ),
                      onPressed: () {
                        setSheetState(() {
                          selectedRating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write your review...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (reviewController.text.isNotEmpty) {
                      addReview(selectedRating, reviewController.text);
                      Navigator.pop(context, calculateAverage()); 
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text("Submit Review",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double average = calculateAverage();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reviews',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, average), 
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text("Overall Ratings", style: TextStyle(fontSize: 18)),
                Text(average.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildStarIcons(average, 28)),
                Text("based on $totalReviews reviews",
                    style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 10),
                buildRatingBars(),
                const Divider(thickness: 1),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return buildReviewTile(
                    review["name"], review["rating"], review["comment"]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showReviewSheet,
        backgroundColor: Colors.orange,
        label: const Text("Write Review",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        icon: const Icon(Icons.edit),
      ),
    );
  }

  List<Widget> buildStarIcons(double rating, double size) {
    int fullStars = rating.floor();
    bool hasHalf = (rating - fullStars) >= 0.3 && (rating - fullStars) < 0.8;
    return List.generate(5, (i) {
      if (i < fullStars) return Icon(Icons.star, color: Colors.orange, size: size);
      if (i == fullStars && hasHalf) return Icon(Icons.star_half, color: Colors.orange, size: size);
      return Icon(Icons.star_border, color: Colors.grey.shade300, size: size);
    });
  }

  Widget buildRatingBars() {
    List<String> labels = ["Excellent", "Good", "Average", "Below Avg", "Poor"];
    List<Color> colors = [Colors.green, Colors.lightGreen, Colors.yellow, Colors.orange, Colors.red];

    return Column(
      children: List.generate(5, (index) {
        double percentage =
            totalReviews == 0 ? 0 : ratingCounts[index] / totalReviews;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(width: 90, child: Text(labels[index])),
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage,
                  color: colors[index],
                  backgroundColor: Colors.grey[300],
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(ratingCounts[index].toString()),
            ],
          ),
        );
      }),
    );
  }

  Widget buildReviewTile(String name, double rating, String comment) {
    return ListTile(
      leading: const CircleAvatar(backgroundImage: AssetImage('assets/user.png')),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: buildStarIcons(rating, 18)),
          Text(comment, maxLines: 3, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
