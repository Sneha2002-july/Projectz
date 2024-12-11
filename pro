import java.awt.CardLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

import com.HIS.Controller.DoctorTableModel;
import com.HIS.view.BrowserPanel;
import com.HIS.view.DoctorProfilePanel;
public class App {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFrame frame = new JFrame("Doctor Management System");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(800, 600);
            CardLayout cardLayout = new CardLayout();
            JPanel container = new JPanel(cardLayout);
            DoctorTableModel tableModel = new DoctorTableModel();
            DoctorProfilePanel profilePanel = new DoctorProfilePanel(cardLayout, container, tableModel);
            BrowserPanel browserPanel = new BrowserPanel(cardLayout, container, tableModel);
            container.add(profilePanel, "Profile");
            container.add(browserPanel, "Browser");
            frame.add(container);
            frame.setVisible(true);
        });
    }
}

import java.util.ArrayList;
import java.util.List;

import javax.swing.table.AbstractTableModel;

import com.HIS.model.Doctor;
import com.HIS.model.JsonHandler;

public class DoctorTableModel extends AbstractTableModel {
    private ArrayList<Doctor> doctors;
    private List<Doctor> filteredDoctors;
    private final String[] columnNames = {"ID", "Name", "Contact", "Email","Address","DOB","Age","Department", "Specialization","Qualification", "Start Time", "End Time","Available from","Available To"};
  private JsonHandler jsonHandler;
    public DoctorTableModel() {
    	jsonHandler = new JsonHandler();
    	this.doctors = jsonHandler.readFromJson();
    	this.filteredDoctors = jsonHandler.readFromJson();
    	Doctor.setIdCounter(filteredDoctors.size());
    	if(doctors==null){
    		doctors = new ArrayList<>();
    	}
    	if(filteredDoctors==null) {
    		this.filteredDoctors = new ArrayList<>();
    	}
    }
    public void addDoctor(Doctor doctor) {
        doctors.add(doctor);
        jsonHandler.writeToJson(doctors);
        filteredDoctors.add(doctor);
        fireTableDataChanged();
    }
    public void filter(String query) {
        filteredDoctors.clear();
        for (Doctor doctor : doctors) {
            if (String.valueOf(doctor.getId()).contains(query)
                    || doctor.getName().toLowerCase().contains(query)
                    || doctor.getContact().toLowerCase().contains(query)
                    ||doctor.getEmail().toLowerCase().contains(query)
                    || doctor.getSpecialization().toLowerCase().contains(query)) {
                filteredDoctors.add(doctor);
            }
        }
        fireTableDataChanged();
    }

    public void resetFilter() {
        filteredDoctors.clear();
        filteredDoctors.addAll(doctors);
        fireTableDataChanged();
    }

    @Override
    public int getRowCount() {
        return filteredDoctors.size();
    }

    @Override
    public int getColumnCount() {
        return columnNames.length;
    }
    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Doctor doctor = filteredDoctors.get(rowIndex);
        switch (columnIndex) {
            case 0:return doctor.getId();
            case 1: return doctor.getName();
            case 2: return doctor.getContact();
            case 3: return doctor.getEmail();
            case 4: return doctor.getAddress();
            case 5: return doctor.getDob();
            case 6: return doctor.getAge();
            case 7: return doctor.getDepartment();
            case 8: return doctor.getSpecialization();
            case 9: return doctor.getQualification();
            case 10: return doctor.getStartTime();
            case 11: return doctor.getEndTime();
            case 12: return doctor.getAvailableFromDay();
            case 13: return doctor.getAvailableToDay();
            default: return null;
        }
    }


    @Override
    public String getColumnName(int column) {
        return columnNames[column];
    }
}


import java.time.LocalDate;
public class Doctor {
    private static int idCounter;  
    private int id;
    private String name;
	private String contact;
	private String email;
	private String address;
	private LocalDate dob;
    private int age;
    private String department;
    private String specialization;
    private String qualification;
    private String startTime;
    private String endTime;
    private String availableFromDay;
    private String availableToDay;
    public Doctor( String name, String contact, String email, String address, LocalDate dob, int age,
			String department, String specialization, String qualification, String startTime, String endTime,
			String availableFromDay, String availableToDay) {
		super();
		this.id = idCounter++;
		this.name = name;
		this.contact = contact;
		this.email = email;
		this.address = address;
		this.dob = dob;
		this.age = age;
		this.department = department;
		this.specialization = specialization;
		this.qualification = qualification;
		this.startTime = startTime;
		this.endTime = endTime;
		this.availableFromDay = availableFromDay;
		this.availableToDay = availableToDay;
	}
	public Doctor() {
		super();
	}
	public static int getIdCounter() {
		return idCounter;
	}
	public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getContact() {
        return contact;
    }

    public int getAge() {
        return age;
    }

    public String getSpecialization() {
        return specialization;
    }

    public String getStartTime() {
        return startTime;
    }

    public String getEndTime() {
        return endTime;
    }
    public static void setIdCounter(int idCounter) {
		Doctor.idCounter = idCounter;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public LocalDate getDob() {
		return dob;
	}
	public void setDob(LocalDate dob) {
		this.dob = dob;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	public String getAvailableFromDay() {
		return availableFromDay;
	}
	public void setAvailableFromDay(String availableFromDay) {
		this.availableFromDay = availableFromDay;
	}
	public String getAvailableToDay() {
		return availableToDay;
	}
	public void setAvailableToDay(String availableToDay) {
		this.availableToDay = availableToDay;
	}

	public Object[] toArray() {
        return new Object[]{name, contact, email, address, dob, age, department, specialization,
                qualification, startTime, endTime, availableFromDay, availableToDay};
    }
}


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.core.exc.StreamWriteException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

public class JsonHandler {
	private ObjectMapper mapper=new ObjectMapper();
	public JsonHandler() {
		mapper.registerModule(new JavaTimeModule());
	}
	String filePath = "DoctorsProfile.json";
	public void writeToJson(ArrayList<Doctor> doctors) {
		try {
			mapper.writerWithDefaultPrettyPrinter().writeValue(new File(filePath), doctors);
		} catch (StreamWriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DatabindException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	public ArrayList<Doctor> readFromJson(){
		try {
			return mapper.readValue(new File(filePath), new TypeReference<ArrayList<Doctor>>() {});
		} catch (StreamReadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DatabindException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

import com.HIS.Controller.DoctorTableModel;

public class BrowserPanel extends JPanel {
    public BrowserPanel(CardLayout cardLayout, JPanel container, DoctorTableModel tableModel) {
        setLayout(new BorderLayout(10, 10));
        setBorder(BorderFactory.createTitledBorder("Doctor Browser"));

        JTable doctorTable = new JTable(tableModel);
        JScrollPane scrollPane = new JScrollPane(doctorTable);
        add(scrollPane, BorderLayout.CENTER);

        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 10));
        searchPanel.add(new JLabel("Search:"));
        JTextField searchField = new JTextField(20);
        searchPanel.add(searchField);

        JButton searchButton = new JButton("Search");
        searchButton.addActionListener(e -> tableModel.filter(searchField.getText().trim().toLowerCase()));

        JButton resetButton = new JButton("Reset");
        resetButton.addActionListener(e -> {
            searchField.setText("");
            tableModel.resetFilter();
        });

        searchPanel.add(searchButton);
        searchPanel.add(resetButton);
        add(searchPanel, BorderLayout.NORTH);

        JButton goToProfileButton = new JButton("Go to Profile Page");
        goToProfileButton.addActionListener(e -> cardLayout.show(container, "Profile"));
        add(goToProfileButton, BorderLayout.SOUTH);
    }
}

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerDateModel;
import javax.swing.SpinnerListModel;

import com.HIS.Controller.DoctorTableModel;
import com.HIS.model.Doctor;
import com.toedter.calendar.JDateChooser;

public class DoctorProfilePanel extends JPanel {
    private JTextField nameField, contactField, emailField, addressField, ageField, qualificationField;
    private JComboBox<String> departmentDropdown, specializationDropdown;
    private JSpinner startTimeSpinner, endTimeSpinner, availableFromDaySpinner, availableToDaySpinner;
    private JDateChooser dobPicker;

    public DoctorProfilePanel(CardLayout cardLayout, JPanel container, DoctorTableModel tableModel) {
        setLayout(new BorderLayout(10, 10));
        setBorder(BorderFactory.createTitledBorder("Doctor Profile"));
        JPanel formPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.anchor = GridBagConstraints.WEST;
        gbc.fill = GridBagConstraints.HORIZONTAL;

        // Input fields
        nameField = new JTextField(20);
        contactField = new JTextField(20);
        emailField = new JTextField(20);
        addressField = new JTextField(20);
        ageField = new JTextField(20);
        qualificationField = new JTextField(20);

        departmentDropdown = new JComboBox<>(new String[]{"Cardiology", "Dermatology", "Neurology", "Pediatrics", "Ophthalmology"});
        specializationDropdown = new JComboBox<>(new String[]{"Pediatric Cardiology", "Electropsysiology", "Neuroimmunology", "epileptologist", " Pediatric Ophthalmologist", "Sports Medicine","Cosmetic dermatology","Pediatric neurology","Gastroenterologist"});
        
        startTimeSpinner = new JSpinner(new SpinnerDateModel());
        endTimeSpinner = new JSpinner(new SpinnerDateModel());
        availableFromDaySpinner = new JSpinner(new SpinnerListModel(new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}));
        availableToDaySpinner = new JSpinner(new SpinnerListModel(new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}));

        // Format spinners
        startTimeSpinner.setEditor(new JSpinner.DateEditor(startTimeSpinner, "HH:mm"));
        endTimeSpinner.setEditor(new JSpinner.DateEditor(endTimeSpinner, "HH:mm"));

        
        dobPicker = new JDateChooser();

        // Add fields to the form
        addField(formPanel, gbc, "Doctor Name:", nameField, 0);
        addField(formPanel, gbc, "Contact:", contactField, 1);
        addField(formPanel, gbc, "Email:", emailField, 2);
        addField(formPanel, gbc, "Address:", addressField, 3);
        addField(formPanel, gbc, "Age:", ageField, 4);
        addField(formPanel, gbc, "Qualification:", qualificationField, 5);
        addField(formPanel, gbc, "Department:", departmentDropdown, 6);
        addField(formPanel, gbc, "Specialization:", specializationDropdown, 7);
        addField(formPanel, gbc, "Start Time:", startTimeSpinner, 8);
        addField(formPanel, gbc, "End Time:", endTimeSpinner, 9);
        addField(formPanel, gbc, "Date of Birth:", dobPicker, 10);
        addField(formPanel, gbc, "Available From Day:", availableFromDaySpinner, 11);
        addField(formPanel, gbc, "Available To Day:", availableToDaySpinner, 12);

        gbc.gridx = 0;
        gbc.gridy = 13;
        gbc.gridwidth = 2;
        gbc.anchor = GridBagConstraints.CENTER;

        // Buttons for Save and Clear
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 10));
        JButton saveButton = new JButton("Save");
        saveButton.addActionListener(e -> saveDoctorProfile(tableModel));
        JButton clearButton = new JButton("Clear");
        clearButton.addActionListener(e -> clearFields());
        buttonPanel.add(saveButton);
        buttonPanel.add(clearButton);

        formPanel.add(buttonPanel, gbc);

        add(formPanel, BorderLayout.CENTER);

        JButton goToBrowserButton = new JButton("Go to Browser Page");
        goToBrowserButton.addActionListener(e -> cardLayout.show(container, "Browser"));
        add(goToBrowserButton, BorderLayout.SOUTH);
    }

    private void addField(JPanel panel, GridBagConstraints gbc, String label, JComponent field, int row) {
        gbc.gridx = 0;
        gbc.gridy = row;
        gbc.weightx = 0.2;
        panel.add(new JLabel(label), gbc);

        gbc.gridx = 1;
        gbc.weightx = 0.8;
        panel.add(field, gbc);
    }

    private void saveDoctorProfile(DoctorTableModel tableModel) {
        String name = nameField.getText().trim();
        String contact = contactField.getText().trim();
        String email = emailField.getText().trim();
        String address = addressField.getText().trim();
        String ageText = ageField.getText().trim();
        String qualification = qualificationField.getText().trim();
        String department = (String) departmentDropdown.getSelectedItem();
        String specialization = (String) specializationDropdown.getSelectedItem();
        Date startTime = (Date) startTimeSpinner.getValue();
        Date endTime = (Date) endTimeSpinner.getValue();
        String availableFromDay = (String) availableFromDaySpinner.getValue();
        String availableToDay = (String) availableToDaySpinner.getValue();
        LocalDate dob = dobPicker.getDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        String formattedStartTime = timeFormat.format(startTime);
        String formattedEndTime = timeFormat.format(endTime);

        if (name.isEmpty() || contact.isEmpty() || email.isEmpty() || address.isEmpty() || ageText.isEmpty() ||
                qualification.isEmpty() || dob==null) {
            JOptionPane.showMessageDialog(this, "Please fill all fields!", "Validation Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try {
            int age = Integer.parseInt(ageText);
            if (age <= 0) {
                JOptionPane.showMessageDialog(this, "Age must be a positive number!", "Validation Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
            //int nextId=tableModel.getRowCount()+1;
            Doctor doctor = new Doctor(name, contact, email, address, dob, age, department, specialization,
                    qualification, formattedStartTime, formattedEndTime, availableFromDay, availableToDay);
            tableModel.addDoctor(doctor);
            JOptionPane.showMessageDialog(this, "Doctor Profile Saved Successfully!");
        } catch (NumberFormatException ex) {
            JOptionPane.showMessageDialog(this, "Age must be a valid number!", "Validation Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void clearFields() {
        nameField.setText("");
        contactField.setText("");
        emailField.setText("");
        addressField.setText("");
        ageField.setText("");
        qualificationField.setText("");
        departmentDropdown.setSelectedIndex(0);
        specializationDropdown.setSelectedIndex(0);
        startTimeSpinner.setValue(new SpinnerDateModel().getDate());
        endTimeSpinner.setValue(new SpinnerDateModel().getDate());   
        availableFromDaySpinner.setValue("Monday");
        availableToDaySpinner.setValue("Monday");
    }
}
