import java.util.ArrayList;
import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
//secret key: 6Lfv7yEaAAAAAHxUWxL4yVvuGGHv3DJKq6fmOCwR
@Entity
public class Hotel {
	@Id
	@GeneratedValue
	int hid;
	double price;
	int userRating;
	double distanceToCityCenter;
	int stars;
	String address;
	
	@ElementCollection
	@CollectionTable(name="inculded_meals", joinColumns= @JoinColumn(name="hid"))
	@Column(name="meals")
	List<String> includingMeals;
	@OneToMany(mappedBy="hotel")
	List<Rate> rates;
	@OneToMany(mappedBy="hotel")
	List<Reservation> reservations;
	@ElementCollection
	@CollectionTable(name="hotel_images", joinColumns=@JoinColumn(name="hid"))
	@Column(name="image")
	List<String> images;
}
